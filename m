Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbUK2P2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUK2P2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUK2P2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:28:12 -0500
Received: from smtp07.auna.com ([62.81.186.17]:62639 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261727AbUK2P2G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:28:06 -0500
Date: Thu, 25 Nov 2004 02:31:27 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.10-rc2-mm3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041121223929.40e038b2.akpm@osdl.org>
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org> (from akpm@osdl.org on
	Mon Nov 22 07:39:29 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101349887l.29107l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

On 2004.11.22, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/
> 

Problem with /sys/bus/i2c/devices empty.

I am running a 2.10-rc2-mm3 kernel with a couple pathes (unrelated to
i2c). It shows me an empty directory in /sys/bus/i2c/devices, even
if I have all suitable modules loaded:

Module                  Size  Used by
w83627hf               24224  0 
i2c_dev                 8192  0 
i2c_sensor              3328  1 w83627hf
i2c_isa                 2304  0 
i2c_i801                7692  0 
i2c_core               18560  5 w83627hf,i2c_dev,i2c_sensor,i2c_isa,i2c_i801

On boxes running 2.6.9, the devices are present with the same module list
(different adapters)

w83627hf               25576  0 
i2c_sensor              2912  1 w83627hf
i2c_isa                 1728  0 
i2c_dev                 7712  0 
i2c_core               18624  4 w83627hf,i2c_sensor,i2c_isa,i2c_dev
annwn:~# ls /sys/bus/i2c/devices
0-0290@

i2c_dev                 7488  - 
w83627hf               25524  - 
eeprom                  6412  - 
i2c_sensor              2732  - 
i2c_isa                 1516  - 
i2c_viapro              5944  - 
i2c_core               18220  - 
nada:~# ls /sys/bus/i2c/devices
0-0050@  0-0051@  0-0052@  0-0053@  1-0290@

Any ideas ?

TIA


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


