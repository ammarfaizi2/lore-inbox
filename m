Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271898AbTG2Q0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271892AbTG2Q0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:26:44 -0400
Received: from smart.cn.stir.ac.uk ([139.153.168.125]:31370 "HELO
	smart.cn.stir.ac.uk") by vger.kernel.org with SMTP id S271898AbTG2Q0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:26:33 -0400
Message-ID: <3F26A036.9060701@cn.stir.ac.uk>
Date: Tue, 29 Jul 2003 17:26:30 +0100
From: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfsroot bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

we are running diskless here.

DHCP works fine. However the mount does not work with 2.6-test2:
Jul 29 17:03:39 roulade rpc.mountd: bad path in mount request from 
139.153.168.129: "139.153.168.134:/clients/root/sauerkraut"

The same with 2.4.21:
Jul 29 17:06:07 roulade rpc.mountd: authenticated mount request from 
sauerkraut.cn.stir.ac.uk:800 for /clients/root/sauerkraut 
(/clients/root/sauerkraut)


Grub:
title Kernel network
dhcp
root (nd)
kernel /clients/tftpboot/sauerkraut/bzImage root=/dev/nfs ip=dhcp
#
#
title Krnl-2.6 network
dhcp
root (nd)
kernel /clients/tftpboot/sauerkraut/bzImage-2.6 root=/dev/nfs ip=dhcp

The path is supplied by the DHCP server. Maybe there's something 
wrong? I'll try to supply it explicitely now.

/Bernd
-- 
http://www.cn.stir.ac.uk/~bp1
mailto:bp1@cn.stir.ac.uk


