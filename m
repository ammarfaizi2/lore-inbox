Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbVCQPQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbVCQPQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVCQPQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:16:42 -0500
Received: from gandalf.light-speed.de ([82.165.28.152]:50118 "EHLO
	gandalf.light-speed.de") by vger.kernel.org with ESMTP
	id S263087AbVCQPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:16:39 -0500
Message-ID: <42399F54.1010108@light-speed.de>
Date: Thu, 17 Mar 2005 16:16:36 +0100
From: Jens Langner <Jens.Langner@light-speed.de>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20050206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11.4 1/1] fs: new filesystem implementation VXEXT1.0 
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following URL is link to a large patch for a possible integration of 
a new filesystem implementation in the misc section of the kernel tree. 
It features a reverse engineered implementation of the so called 
VXEXT1.0 DOS filesystem which is commonly used on VxWorks RTOS systems 
from Wind River Inc., where the "extended DOS filesystem" mode is enabled.

The VXEXT filesystem is more or less a FAT16 based filesystem which was 
slightly modified by Wind River to allow the storage of more than 2GB 
data on a partition, as well as storing filenames with a maximum of 40 
characters length. To achieve that, VxWorks uses a dynamic cluster size 
calculation which is based on the partition size where clusters can be 
larger than 32K. In addition, it uses a slightly modified directroy
entry structure to allow to store filenames larger than 8+3 characters.

Please find the patch file accessible through the following URL:
http://www.jens-langner.de/vxext_fs/vxext_fs_1_0-linux-2.6.11.4.patch

In addition, refer the detailed technical documentation on my 
implementation and the root directory of my distribution as well:
http://www.jens-langner.de/vxext_fs/Documentation/vxext.txt
http://www.jens-langner.de/vxext_fs/

Please note that large portions of the implementation are based on the 
already existing FAT16 (msdos) implementation in the kernel tree. 
However, instead of patching/drilling the original FAT16 implementation, 
an "outsourced" rework for developing the VEXT implementation was 
considered.

cheers,
jens
-- 
Jens Langner                                         Ph: +49-351-4716545
Lannerstrasse 1
01219 Dresden                                Jens.Langner@light-speed.de
Germany                                      http://www.jens-langner.de/
