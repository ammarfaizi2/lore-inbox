Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319234AbSH2PoY>; Thu, 29 Aug 2002 11:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSH2PoY>; Thu, 29 Aug 2002 11:44:24 -0400
Received: from ns.suse.de ([213.95.15.193]:48392 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319234AbSH2PoY>;
	Thu, 29 Aug 2002 11:44:24 -0400
Date: Thu, 29 Aug 2002 17:48:45 +0200
From: Dave Jones <davej@suse.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, junio@siamese.dyndns.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
Message-ID: <20020829174845.G17887@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Thunder from the hill <thunder@lightweight.ods.org>,
	Rusty Russell <rusty@rustcorp.com.au>, junio@siamese.dyndns.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020828221716.1A73C2C09E@lists.samba.org> <Pine.LNX.4.44.0208290938180.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208290938180.3234-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Thu, Aug 29, 2002 at 09:39:14AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 09:39:14AM -0600, Thunder from the hill wrote:

 > > 	#define strlen(x) \
 > > 		(__builtin_constant_p(x) && sizeof(x) != sizeof(char *)
 > > 		? (sizeof(x) - 1) : __strlen(x))
 > 
 > I must say that doesn't make the code any cleaner, which leads to it being 
 > not as clean as Keith suggested. It was a code cleanup, not a code messup.

Sure the macro is fugly, but the code that uses it becomes
cleaner which was the whole point here.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
