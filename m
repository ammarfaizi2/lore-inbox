Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVACBND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVACBND (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVACBND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:13:03 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:24262 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261362AbVACBMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:12:54 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: the umount() saga for regular linux desktop users
To: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Oliver Neukum <oliver@neukum.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 03 Jan 2005 02:17:14 +0100
References: <fa.foeqpaf.nlmd9n@ifi.uio.no> <fa.d9avdr3.1jm46gr@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1ClGqQ-0001Ah-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Jan 02, 2005 at 09:34:16PM +0100, Oliver Neukum wrote:

>> 3. Is a race condition.
> 
> Then put it into a while loop that executes until umount returns 0.

#!/bin/sh
for ((i=0;i<7;i++))
do while true; do sh -c 'chdir /mnt/cdrom;sleep 2147483647';done&
done

