Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTIBPkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 11:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTIBPib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 11:38:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:7091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263871AbTIBPh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 11:37:58 -0400
Date: Tue, 2 Sep 2003 08:32:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Ramit Bhalla" <ramit.bhalla@wipro.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Bug in vsprintf.c - vsscanf()
Message-Id: <20030902083203.04df1d13.rddunlap@osdl.org>
In-Reply-To: <52C85426D39B314381D76DDD480EEE0CFC69DC@blr-m3-msg.wipro.com>
References: <52C85426D39B314381D76DDD480EEE0CFC69DC@blr-m3-msg.wipro.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Sep 2003 10:29:07 +0530 "Ramit Bhalla" <ramit.bhalla@wipro.com> wrote:

| Oh sorry - 
| It's the 2.4.19 kernel version.

In that case you can look at more recent kernel versions and
see that it's already fixed.

~Randy

| -----Original Message-----
| From: Randy.Dunlap [mailto:rddunlap@osdl.org]
| Sent: Monday, September 01, 2003 11:34 PM
| To: Ramit Bhalla
| Cc: linux-kernel@vger.kernel.org; alan@redhat.com
| Subject: Re: Bug in vsprintf.c - vsscanf()
| 
| 
| > Hi,
| >
| > There appears to be a bug in vsprintf.c
| > The function vsscanf (if I'm correct) is the kernel mode equivalent of user
| > mode sscanf. If one tries to read a hex string using the format "%x" it
| > returns an error if the read buffer contains any character other than 0-9.
| >
| > I believe the culprit lies on line 640 of vsprintf.c
| >
| > It should be "isxdigit" instead of "isdigit".
| >
| > Hope I'm not missing anything here :)
| 
| Like what kernel version...?
| 
| If it's 2.4.x, is it recent?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 2 Sep 2003 10:29:07 +0530 "Ramit Bhalla" <ramit.bhalla@wipro.com> wrote:

| Oh sorry - 
| It's the 2.4.19 kernel version.

In that case you can look at more recent kernel versions and
see that it's already fixed.

~Randy

| -----Original Message-----
| From: Randy.Dunlap [mailto:rddunlap@osdl.org]
| Sent: Monday, September 01, 2003 11:34 PM
| To: Ramit Bhalla
| Cc: linux-kernel@vger.kernel.org; alan@redhat.com
| Subject: Re: Bug in vsprintf.c - vsscanf()
| 
| 
| > Hi,
| >
| > There appears to be a bug in vsprintf.c
| > The function vsscanf (if I'm correct) is the kernel mode equivalent of user
| > mode sscanf. If one tries to read a hex string using the format "%x" it
| > returns an error if the read buffer contains any character other than 0-9.
| >
| > I believe the culprit lies on line 640 of vsprintf.c
| >
| > It should be "isxdigit" instead of "isdigit".
| >
| > Hope I'm not missing anything here :)
| 
| Like what kernel version...?
| 
| If it's 2.4.x, is it recent?
