Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUHTPhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUHTPhj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHTPhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:37:39 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:180 "EHLO
	acheron.informatik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S268236AbUHTPhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:37:09 -0400
Message-ID: <41261A8F.6040609@bio.ifi.lmu.de>
Date: Fri, 20 Aug 2004 17:36:47 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pankaj Agarwal <pankaj@pnpexports.com>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: how to identify filesystem type
References: <001901c485cc$208c3a60$9159023d@dreammachine> <je657fzchp.fsf@sykes.suse.de> <000901c486c9$40d92e60$6d59023d@dreammachine>
In-Reply-To: <000901c486c9$40d92e60$6d59023d@dreammachine>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pankaj Agarwal wrote:
> Hi Andreas,
> 
> this is the output when you have a mounted block device.....you can only
> mount when you know the filesystem ....thats wat i wanna know...hoe to
> identify filesytems...on ablockdevice.

And when it's not mounted, the output is still enough:

zassenhaus /root# grep /dev/hda7 /proc/mounts
zassenhaus /root# file -s /dev/hda7
/dev/hda7: ReiserFS V3.6 block size 4096 num blocks 11378028 r5 hash

galois fst/tmp# grep /dev/hda8 /proc/mounts
galois fst/tmp# file -s /dev/hda8
/dev/hda8: Linux rev 1.0 ext3 filesystem data

That's all you need to know...

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

