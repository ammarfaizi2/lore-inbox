Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUIBOJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUIBOJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268331AbUIBOJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:09:06 -0400
Received: from host81-154-216-60.range81-154.btcentralplus.com ([81.154.216.60]:30913
	"EHLO worthy.swandive.local") by vger.kernel.org with ESMTP
	id S268330AbUIBOIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:08:55 -0400
Message-ID: <41372971.4060600@btinternet.com>
Date: Thu, 02 Sep 2004 15:08:49 +0100
From: Grant Wilson <gww@btinternet.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: appro@fy.chalmers.se
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problem with cdrom-range-fixes-patch in 2.6.9-rc1-mm2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
With this patch applied a CDROMVOLREAD ioctl returns EINVAL.  I believe 
that this is because of an error in the 'sanity check' added by the patch:

if ((buffer[offset] & 0x3f) == GPMODE_AUDIO_CTL_PAGE ||
                             ^^
                  should be  !=

Yours,
Grant Wilson
