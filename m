Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUBZWhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUBZWgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:36:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:56060 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261183AbUBZWgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:36:10 -0500
Message-ID: <403E74D3.4000305@roemling.net>
Date: Thu, 26 Feb 2004 23:36:03 +0100
From: Jochen Roemling <jochen@roemling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: shmget with SHM_HUGETLB flag: Operation not permitted
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:35bace2e8eeec41a1b9500b782c09cc4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using stock kernel 2.6.2. I have HUGETLB support compiled in.

CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y

When issuing this command in a C pgm

shmid =shmget(IPC_PRIVATE, SOMESIZE, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W)

I get "Operation not Permitted" when running it as a normal user. It
works for root. Without the SHM_HUGETLB flag it works fine for all users.

How can I grant the permission to use HUGETLB to ordinary users?


Jochen



