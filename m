Return-Path: <linux-kernel-owner+w=401wt.eu-S932314AbXAONU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbXAONU1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbXAONU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:20:26 -0500
Received: from luna.alliedvisiontec.com ([213.203.238.80]:54462 "EHLO
	luna.alliedvisiontec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbXAONU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:20:26 -0500
Subject: Re: ieee1394 feature needed: overwrite SPLIT_TIMEOUT from userspace
From: Philipp Beyer <philipp.beyer@alliedvisiontec.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.0ae1f576575bc02e@s5r6.in-berlin.de>
References: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local>
	 <tkrat.0ae1f576575bc02e@s5r6.in-berlin.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Jan 2007 14:21:11 +0100
Message-Id: <1168867271.5190.9.camel@ahr-pbe-lx.avtnet.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your input. My post was based on the (wrong) idea that
the kernel already uses different timeout values per node.

Therefore, having read your answer, I have a different opinion about
how to solve this now.

About your suggestions:
Unfortunately sending an early response and using a secondary register
as indication for completed flash writes doesnt work. In short, the
device isn't able to process packets while writing to flash and an early
answer followed by a period of non-responsiveness might lead to problems
on the windows side.

Also I dont like the idea of having such a big timeout for every bus
transaction. In case of 'normal' operation the device runs fine with
a standard timeout value.



I will now try to work around this problem in userspace basically by
ignoring the timeout error. The correct transmission of the write 
request will already be confirmed by the acknowledge packet, after all.


Philipp Beyer


