Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272441AbRH3Uoz>; Thu, 30 Aug 2001 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272443AbRH3Uop>; Thu, 30 Aug 2001 16:44:45 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:48396 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272441AbRH3Uo0>; Thu, 30 Aug 2001 16:44:26 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108302044.f7UKi7c20040@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Aug 2001 22:44:07 +0200 (MET DST)
Cc: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   if sizeof(typeof(a)) != sizeof(typeof(b))
>       BUG() // sizes differ

this is not neccessarily a problem. should work with char/short char/int
short/int comparison.

only problem seems to be signed/unsigned int comparison.

>   const (typeof(a)) _a = ~(typeof(a))0
>   const (typeof(b)) _b = ~(typeof(b))0
>   if _a < 0 && _b > 0 || _a > 0 && b < 0
>       BUG() // one signed, the other unsigned
>   standard_max(a,b)

if sizeof(typeof(a))==sizeof(int) && sizeof(typeof(b))==sizeof(int) &&
   ( _a < 0 && _b > 0 || _a > 0 && b < 0 )
	BUG() // signed unsigned int compare

