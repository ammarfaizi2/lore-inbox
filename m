Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272325AbRH3Qix>; Thu, 30 Aug 2001 12:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272323AbRH3Qin>; Thu, 30 Aug 2001 12:38:43 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:45328 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272325AbRH3Qi2>;
	Thu, 30 Aug 2001 12:38:28 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108301638.SAA04923@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com>
 "from Linus Torvalds at Aug 30, 2001 09:09:13 am"
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Thu, 30 Aug 2001 18:38:40 +0200 (CEST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Linus Torvalds wrote:"
> What if the "int" happens to be negative?

   if sizeof(typeof(a)) != sizeof(typeof(b)) 
       BUG() // sizes differ
   const (typeof(a)) _a = ~(typeof(a))0   
   const (typeof(b)) _b = ~(typeof(b))0   
   if _a < 0 && _b > 0 || _a > 0 && b < 0
       BUG() // one signed, the other unsigned
   standard_max(a,b)


Peter 
