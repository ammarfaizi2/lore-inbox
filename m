Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUH3S4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUH3S4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUH3Szv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:55:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:43718 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268965AbUH3S10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:27:26 -0400
Message-ID: <4133718D.60002@grupopie.com>
Date: Mon, 30 Aug 2004 19:27:25 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com>
In-Reply-To: <20040829162252.GG5492@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.37; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Aug 25, 2004 at 12:22:09AM +0900, mita akinobu wrote:
> 
>>The readprofile command does not print the number of clock ticks about
>>the last element in profiling buffer.
>>Since the number of clock ticks which occur on the module functions is
>>as same as the value of the last element of prof_buffer[]. when many
>>ticks occur on there, some users who browsing the output of readprofile
>>may overlook the fact that the bottle-neck may exist in the modules.
>>I create the patch which enable to print clock ticks of the last
>>element as "*unknown*".
> 
> 
> Well, since I couldn't stop vomiting for hours after I looked at the
> code for readprofile(1), here's a reimplementation, with various
> misfeatures removed, included as a MIME attachment.

While you're at it, can readprofile work by reading the symbols from 
/proc/kallsyms?

If it can, this could be added to the list of files that it tries to 
open, so that it could work even if System.map wasn't available.

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
