Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWAJNqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWAJNqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWAJNqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:46:10 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:54921 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751010AbWAJNqJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:46:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X2cvR9dY3R3iosNRoITSiZRwVshllbvNTqkxdudbqLQ1fXDA9bO7GAe61o0ku20eF/nMZnjvPq2MM78pRbCT3lfKEU3tOGBl+8QJkcOwD7bTOKGlIGXXvehm2qYltiHkaMq1b7i/6S+oVtBPVnrlEN2WtoVRpkhql4kaSQDRdKw=
Message-ID: <9a8748490601100546s2dcf9a25hcfd369e397bd7938@mail.gmail.com>
Date: Tue, 10 Jan 2006 14:46:08 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML List <linux-kernel@vger.kernel.org>
Subject: 2.6.15-mm2 allyesconfig build failure in drivers/usb/ip/
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allyesconfig currently doesn't build completely for me in 2.6.15-mm2

Here's what I did and the results :


$ make allyesconfig
 ...
$ make -j 3
 ...
  CC      drivers/scsi/53c700.o
  CC      net/sysctl_net.o
  LD      net/xfrm/built-in.o
  LD      net/built-in.o
  LD      drivers/scsi/built-in.o
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....
$ make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  LD      drivers/usb/ip/built-in.o
drivers/usb/ip/stub.o(.text+0xc7d): In function `usbip_pack_pdu':
drivers/usb/ip/usbip_common.c:748: multiple definition of `usbip_pack_pdu'
drivers/usb/ip/vhci-hcd.o(.text+0xc7d):drivers/usb/ip/usbip_common.c:748:
first defined here
drivers/usb/ip/stub.o(.text+0xb82): In function `usbip_task_init':
drivers/usb/ip/usbip_common.c:696: multiple definition of `usbip_task_init'
drivers/usb/ip/vhci-hcd.o(.text+0xb82):drivers/usb/ip/usbip_common.c:696:
first defined here
drivers/usb/ip/stub.o(.text+0x5bf): In function `setreuse':
drivers/usb/ip/usbip_common.c:506: multiple definition of `setreuse'
drivers/usb/ip/vhci-hcd.o(.text+0x5bf):drivers/usb/ip/usbip_common.c:506:
first defined here
drivers/usb/ip/stub.o(.text+0xe4c): In function `usbip_start_eh':
drivers/usb/ip/usbip_event.c:31: multiple definition of `usbip_start_eh'
drivers/usb/ip/vhci-hcd.o(.text+0xe4c):drivers/usb/ip/usbip_event.c:31:
first defined here
drivers/usb/ip/stub.o(.data+0x0): In function `usbip_xmit':
drivers/usb/ip/usbip_common.c:36: multiple definition of `usbip_debug_flag'
drivers/usb/ip/vhci-hcd.o(.data+0x0):drivers/usb/ip/usbip_common.c:36:
first defined here
drivers/usb/ip/stub.o(.text+0xd61): In function `usbip_recv_xbuff':
drivers/usb/ip/usbip_common.c:803: multiple definition of `usbip_recv_xbuff'
drivers/usb/ip/vhci-hcd.o(.text+0xd61):drivers/usb/ip/usbip_common.c:803:
first defined here
drivers/usb/ip/stub.o(.text+0x57d): In function `setkeepalive':
drivers/usb/ip/usbip_common.c:495: multiple definition of `setkeepalive'
drivers/usb/ip/vhci-hcd.o(.text+0x57d):drivers/usb/ip/usbip_common.c:495:
first defined here
drivers/usb/ip/stub.o(.text+0x696): In function `socket_to_addrstr':
drivers/usb/ip/usbip_common.c:570: multiple definition of `socket_to_addrstr'
drivers/usb/ip/vhci-hcd.o(.text+0x696):drivers/usb/ip/usbip_common.c:570:
first defined here
drivers/usb/ip/stub.o(.text+0x4f9): In function `setquickack':
drivers/usb/ip/usbip_common.c:473: multiple definition of `setquickack'
drivers/usb/ip/vhci-hcd.o(.text+0x4f9):drivers/usb/ip/usbip_common.c:473:
first defined here
drivers/usb/ip/stub.o(.text+0xab9): In function `usbip_stop_threads':
drivers/usb/ip/usbip_common.c:681: multiple definition of `usbip_stop_threads'
drivers/usb/ip/vhci-hcd.o(.text+0xab9):drivers/usb/ip/usbip_common.c:681:
first defined here
drivers/usb/ip/stub.o(.text+0x27f): In function `usbip_sendmsg':
drivers/usb/ip/usbip_common.c:125: multiple definition of `usbip_sendmsg'
drivers/usb/ip/vhci-hcd.o(.text+0x27f):drivers/usb/ip/usbip_common.c:125:
first defined here
drivers/usb/ip/stub.o(.text+0xd30): In function `usbip_event_happend':
drivers/usb/ip/usbip_common.c:788: multiple definition of `usbip_event_happend'
drivers/usb/ip/vhci-hcd.o(.text+0xd30):drivers/usb/ip/usbip_common.c:788:
first defined here
drivers/usb/ip/stub.o(.text+0x9ac): In function `usbip_thread':
drivers/usb/ip/usbip_common.c:638: multiple definition of `usbip_thread'
drivers/usb/ip/vhci-hcd.o(.text+0x9ac):drivers/usb/ip/usbip_common.c:638:
first defined here
drivers/usb/ip/stub.o(.text+0x636): In function `set_sockaddr':
drivers/usb/ip/usbip_common.c:533: multiple definition of `set_sockaddr'
drivers/usb/ip/vhci-hcd.o(.text+0x636):drivers/usb/ip/usbip_common.c:533:
first defined here
drivers/usb/ip/stub.o(.text+0x5cb): In function `sockfd_to_socket':
drivers/usb/ip/usbip_common.c:511: multiple definition of `sockfd_to_socket'
drivers/usb/ip/vhci-hcd.o(.text+0x5cb):drivers/usb/ip/usbip_common.c:511:
first defined here
drivers/usb/ip/stub.o(.text+0xcac): In function `usbip_recv_iso':
drivers/usb/ip/usbip_common.c:764: multiple definition of `usbip_recv_iso'
drivers/usb/ip/vhci-hcd.o(.text+0xcac):drivers/usb/ip/usbip_common.c:764:
first defined here
drivers/usb/ip/stub.o(.text+0x0): In function `usbip_xmit':
drivers/usb/ip/usbip_common.c:36: multiple definition of `usbip_xmit'
drivers/usb/ip/vhci-hcd.o(.text+0x0):drivers/usb/ip/usbip_common.c:36:
first defined here
drivers/usb/ip/stub.o(.data+0x4): In function `usbip_xmit':
drivers/usb/ip/usbip_common.c:36: multiple definition of `dev_attr_usbip_debug'
drivers/usb/ip/vhci-hcd.o(.data+0x4):drivers/usb/ip/usbip_common.c:36:
first defined here
drivers/usb/ip/stub.o(.text+0xee6): In function `usbip_stop_eh':
drivers/usb/ip/usbip_event.c:45: multiple definition of `usbip_stop_eh'
drivers/usb/ip/vhci-hcd.o(.text+0xee6):drivers/usb/ip/usbip_event.c:45:
first defined here
drivers/usb/ip/stub.o(.text+0x81f): In function `usbip_dump_header':
drivers/usb/ip/usbip_common.c:597: multiple definition of `usbip_dump_header'
drivers/usb/ip/vhci-hcd.o(.text+0x81f):drivers/usb/ip/usbip_common.c:597:
first defined here
drivers/usb/ip/stub.o(.text+0xa74): In function `usbip_start_threads':
drivers/usb/ip/usbip_common.c:668: multiple definition of `usbip_start_threads'
drivers/usb/ip/vhci-hcd.o(.text+0xa74):drivers/usb/ip/usbip_common.c:668:
first defined here
drivers/usb/ip/stub.o(.text+0xf75): In function `usbip_event_add':
drivers/usb/ip/usbip_event.c:59: multiple definition of `usbip_event_add'
drivers/usb/ip/vhci-hcd.o(.text+0xf75):drivers/usb/ip/usbip_event.c:59:
first defined here
drivers/usb/ip/stub.o(.text+0x53b): In function `setnodelay':
drivers/usb/ip/usbip_common.c:484: multiple definition of `setnodelay'
drivers/usb/ip/vhci-hcd.o(.text+0x53b):drivers/usb/ip/usbip_common.c:484:
first defined here
make[3]: *** [drivers/usb/ip/built-in.o] Error 1
make[2]: *** [drivers/usb/ip] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
