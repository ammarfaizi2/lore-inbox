Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVI2MlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVI2MlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVI2MlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:41:08 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:38632 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751117AbVI2MlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:41:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fjXFxhtKJw/wlHa0SWLqY5ZJ7n/YVFtUPfateFxBjjQNqEMmI1q7M+O1d12Eu5GKc9YPVDlnmsruYQVeys8+RpywmFoeUOagIW3D9NEvHHh+xQ0G+wXzzSCbE5fjypn0+m3/uz1UuEM01pwpqyV3GJtDumb8aHt3KMWkbF+vsBE=
Message-ID: <433BE0D1.1070501@gmail.com>
Date: Thu, 29 Sep 2005 20:40:49 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net>
In-Reply-To: <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Thu, 29 Sep 2005 05:01:15 +0800, Antonino A. Daplas wrote:
> 
>> Giuseppe Bilotta wrote:
> 
> So as you can see the problem is that the timings are NOT set by
> fbset. No error messages or anything.
> 

Sorry about the blank reply, hit send accidentally.

Probably, the EDID block is incomplete, so nvidiafb is refusing
custom modes.  You can change the #undef DEBUG to #define DEBUG
in drivers/video/fbmon.c to see verbose output of the EDID block in
dmesg.

Then, can you recompile without the DDC/I2C support, and boot with:

video=nvidiafb:1600x1200-60, then play with fbset later on.

If possible, you can also get the latest git snapshot then boot with:

video=nvidiafb:1600x1200MR

Note the appended MR - it's CVT with reduced blanking - which is
for LCD displays especially those manufactured by Dell since they
are the proponents of CVT.
 
Tony
