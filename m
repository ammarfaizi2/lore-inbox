Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSGQSNi>; Wed, 17 Jul 2002 14:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSGQSNi>; Wed, 17 Jul 2002 14:13:38 -0400
Received: from zipcon.net ([209.221.136.5]:43435 "HELO zipcon.net")
	by vger.kernel.org with SMTP id <S316135AbSGQSNh>;
	Wed, 17 Jul 2002 14:13:37 -0400
Message-ID: <3D35B43A.4050804@tahomatech.com>
Date: Wed, 17 Jul 2002 11:15:22 -0700
From: William Waddington <waddington@tahomatech.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kiobufs and highmem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have a 2.4.x char driver which works fine, except in boxes with lots of
memory.

user_buffer -> write() -> map_user_kiobuf() -> pci_map_sg() -> Pci DMA

I'm using the .page/.offset version of the scatterlist, but in the HIGHMEM case,
map_user_kiobuf() seems to return peculiar page addresses.

What is the state of kiobufs/HIGHMEM in 2.4.x?  Do I need to implement
a bounce buffer in the driver?  Some email correspondence indicates so,
but I would be grateful for a definitive word from the kernel folks.

TIA,
Bill Waddington

-- 
*** please note our new name and address ***

Tahoma Technology (formerly Ikon Corporation)
107 2nd Avenue North, Seattle, WA, USA, 98109
Voice: 206.728.6465  Fax: 206.728.1633
http://www.tahomatech.com  tahoma@tahomatech.com


