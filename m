Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVCNVyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVCNVyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCNVys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:54:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:48567 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261976AbVCNVvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:51:03 -0500
Message-ID: <4236073E.6060801@osdl.org>
Date: Mon, 14 Mar 2005 13:50:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] buildcheck: reduce DEBUG_INFO noise from reference* scripts
References: <29073.1110832439@ocs3.ocs.com.au> <42360443.8030606@osdl.org> <20050314214038.GE17925@mars.ravnborg.org>
In-Reply-To: <20050314214038.GE17925@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------040805050203060808090000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040805050203060808090000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sam Ravnborg wrote:
> On Mon, Mar 14, 2005 at 01:38:11PM -0800, Randy.Dunlap wrote:
>  Indeed, it's actually much worse with that patch section added.  :(
> 
>>I don't know how I got there.
>>
>>Sam, can you drop the very first patch section here, or shall I send
>>a new patch for this?
> 
> Incremental patch please. I already have a few patches on top of this in
> bitkeeper.
> 
> 	Sam

Here you go.... back out those 2 lines.

Thanks,
-- 
~Randy

--------------040805050203060808090000
Content-Type: text/x-patch;
 name="refer_discard_no_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refer_discard_no_init.patch"


I should not have added init.text test here;
it's more than useless, it actually degrades the output.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 scripts/reference_discarded.pl |    2 --
 1 files changed, 2 deletions(-)

diff -Naurp ./scripts/reference_discarded.pl~refer_discard_no_init ./scripts/reference_discarded.pl
--- ./scripts/reference_discarded.pl~refer_discard_no_init	2005-03-14 13:44:54.000000000 -0800
+++ ./scripts/reference_discarded.pl	2005-03-14 13:46:07.000000000 -0800
@@ -82,8 +82,6 @@ foreach $object (keys(%object)) {
 		}
 		if (($line =~ /\.text\.exit$/ ||
 		     $line =~ /\.exit\.text$/ ||
-		     $line =~ /\.text\.init$/ ||
-		     $line =~ /\.init\.text$/ ||
 		     $line =~ /\.data\.exit$/ ||
 		     $line =~ /\.exit\.data$/ ||
 		     $line =~ /\.exitcall\.exit$/) &&

--------------040805050203060808090000--
