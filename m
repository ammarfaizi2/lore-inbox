Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTLSHDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 02:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTLSHDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 02:03:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15549 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261262AbTLSHD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 02:03:27 -0500
Message-ID: <3FE2A29D.30608@pobox.com>
Date: Fri, 19 Dec 2003 02:02:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
       linux-tr@linuxtr.net, jschlst@samba.org, cgoos@syskonnect.de,
       mid@auk.cx, jochen@scram.de
Subject: Re: [PATCH][TRIVIAL] dep_tristate wants 3 arguments (fwd)
References: <20031212222655.GH1825@fs.tum.de> <3FDA426B.1060508@pobox.com> <20031212225343.GI1825@fs.tum.de>
In-Reply-To: <20031212225343.GI1825@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Dec 12, 2003 at 05:34:19PM -0500, Jeff Garzik wrote:
> 
>>...
>>
>>>--- linux-5110/drivers/net/tokenring/Config.in
>>>+++ linux-10010/drivers/net/tokenring/Config.in
>>>@@ -21,10 +21,10 @@ if [ "$CONFIG_TR" != "n" ]; then
>>>   dep_tristate '  3Com 3C359 Token Link Velocity XL adapter support' 
>>>   CONFIG_3C359 $CONFIG_TR $CONFIG_PCI
>>>   tristate '  Generic TMS380 Token Ring ISA/PCI adapter support' 
>>>   CONFIG_TMS380TR
>>>   if [ "$CONFIG_TMS380TR" != "n" ]; then
>>>-      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI 
>>>$CONFIG_PCI
>>>-      dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA 
>>>$CONFIG_ISA
>>>-      dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS 
>>>$CONFIG_PCI
>>>-      dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' 
>>>CONFIG_MADGEMC $CONFIG_MCA
>>>+      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI 
>>>$CONFIG_PCI $CONFIG_TMS380TR
>>
>>...
>>dep_tristate statements with only three arguments (include desc. text) 
>>are just fine.  There is no need for additional arguments.
>>
>>	dep_tristate 'blah blah' CONFIG_BLAH dep...
>>
>>Further, adding CONFIG_TMS380TR dependency is complete nonsense, 
>>considering that the "if [ "$CONFIG_TMS380TR" != "n" ]" check remains.
> 
> 
> Consider:
>   CONFIG_TMS380TR=m
> 
> E.g. CONFIG_TMSPCI=y shouldn't be allowed in this case.


Remove the 'if' and you are correct :)

	Jeff



