Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289867AbSBKR2G>; Mon, 11 Feb 2002 12:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289866AbSBKR15>; Mon, 11 Feb 2002 12:27:57 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:55253 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S289859AbSBKR1m>; Mon, 11 Feb 2002 12:27:42 -0500
Message-ID: <3C67FF09.7010900@nyc.rr.com>
Date: Mon, 11 Feb 2002 12:27:37 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.4 Sound Driver Problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the YMFPCI driver on a Toshiba Tecra 8100.

The sound_alloc_dmap() function in dmabuf.c must be changed from using 
__get_free_pages() and virt_to_bus() -> pci_alloc_consistent().

This looked like an easy thing to do, but the only parameter to 
sound_alloc_dmap() is of type struct dma_buffparms -- whose definition I 
couldn't even find -- and pci_alloc_consistent() expects a struct 
pci_dev as a parameter.  I read the driver-model.txt file in the 
Documentation in the hopes of finding some magic __get_pci_dev_by_id(int 
  dev) function, but things are never that easy :).

I tried asking about this in kernelnewbies, but got no response. Anyone 
here want to give me a nudge in the right direction?

