Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269282AbUI3PvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269282AbUI3PvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269304AbUI3PvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:51:25 -0400
Received: from serio.al.rim.or.jp ([202.247.191.123]:37119 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S269282AbUI3PvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:51:22 -0400
Message-ID: <415C2B6C.6050401@yk.rim.or.jp>
Date: Fri, 01 Oct 2004 00:51:08 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
CC: linux-kernel@vger.kernel.org, ishikawa@yk.rim.or.jp
Subject: Re: FSCK message suppressed during booting? (2.6.9-rc2)
References: <E1CCtxn-00075V-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1CCtxn-00075V-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <415B5034.6060809@yk.rim.or.jp> you wrote:
> 
>>That is, under previous 2.4.xx kernel, I would have gotten
>>"The disk was not unmounted cleanly. Running fsck." or
>>some such message and fsck printed its
>>progress bar using ASCII characters.
> 
> 
> Well, this is not a kernel function, your Distribution is calling fsck in
> the bootup scripts, and fsck is calling the filesystem specific
> implementation and this is checking if fsck is needed.
> 
> If you do not get this messages anymore contact your linux distribution
> provider.
> 
> 

Thank you for the comment.

Well, I have installed 2.6.9-rc2 on my own after having used
Debian with my own updated kernel 2.4.2x series for a few years now.
I certainly upgraded moduleutil and other packages to run
2.6.9-rc2, but have not specifically updated fsck.
(I DID ran apt-get -u update and apt-get -u upgrade to pick up
the latest packages a week ago or so.).

Agreed that the starting fsck under stock Debian scheme
may depend on 2.4.xx features which may not be available
on 2.6.yy series kernel. I will get in contact with fsck
package (or boot script) maintainer to see
if we can improve this.

 >Do you habe maybe a journalling filesystem? Or do you have set some 
flags to
 > force the skip of fsck (/fastboot)
 >

Well, I am running 2.6.9-rc2 from loadlin as follows.

loadlin 269rc2 root=/dev/sda6 ro vga=3 scsihosts=sym53c8xx:tmscsim

I noticed the fsck message lines were missing on the reboot after
a hard-hung forced me to hit reset button in the end.
The message lines were missing, but it seems that fsck
certainly was running invisibly. Thus the
boot sequence halted as if the computer got hung again
until fsck finished and bootting continued. This was very
annoying.



-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
