Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264838AbUDWPRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264838AbUDWPRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264842AbUDWPRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:17:09 -0400
Received: from p4.ensae.fr ([195.6.240.202]:17121 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S264838AbUDWPQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:16:55 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Using compression before encryption in device-mapper
Date: Fri, 23 Apr 2004 17:16:53 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <200404221506.43017.Guillaume@Lacote.name> <20040422160033.GB23746@wohnheim.fh-wedel.de>
In-Reply-To: <20040422160033.GB23746@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404231716.53481.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feel free to ignore all of my reply; please note that I am not trying to "be 
right" or to "be wrong" but I still do not understand ... Thank you still for 
your time and pedagogy.

> Yeah, sure, the attacker has no idea what the plaintext of those
> blocks is, but if they appear often enough, it has to be something
> quite common.  Something like, say, all ones or all zeros.  Or like
> one of those 48 common huffman encodings thereof.
> [...]
> So what!  You end up with maybe three bits per zero (assuming all
> zeros).  Depending on the size of random data up front, they start
> with bit 1, 2 or 3.  Makes 3*2^3 or 24 possibilities.  Same for all
> ones, give a total of 48.  Great, a dictionary attack is 48x slower
> now!
> [...]
> Still, towards the end of all-ones or all-zeros, each byte will be
> encoded with the same 1-3bit value.
The point I fail to understand is the following : you know the enciphered 
value of these 1-3bits. But how can you know what is 
compressed-but-deciphered 1-3bit value ? Ok my text contains only 0s. OK 
these 0s appear to be "011" once encrypted. How do you launch your 
dictionnary attack ? You do _not_ (?) know what the 3bit deciphered code for 
"0" is. Or maybe you do ?

> [...]
> In that case, what's your point.  If the key is strong and the
> encryption is strong (I sure hope, AES is), nothing short of brute
> force can be successful.  What are you protecting against?
Maybe my "endless" story is absurd, but I am _not_ protecting against weak 
keys; I am trying to protected against weak _data_ , which is the basis for 
dictionnary attacks even in the case of perfectly random keys.

Thank you for having read till here,
Guillaume.

