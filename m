Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932792AbWBUVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbWBUVSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWBUVSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:18:47 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:15629 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932790AbWBUVSp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:18:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iyhYPVSLO8XOlx4dwNTMA5gGENiKPuQc49k2OgA63EvGhk60qA6JqtO6/V9YFwPK4HxwSFvJfeu4DmYfAa02GGwCL4D2WcagOK48Hzn18Si01tN64I3tmUAKKh2JL2eWsWdMhUeWkvdlTbRMVHVeZPa6MQbG/x5xx5fkCko2icA=
Message-ID: <9a8748490602211318n277d4f52w5c21e7872ba9956@mail.gmail.com>
Date: Tue, 21 Feb 2006 22:18:42 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.16-rc4-mm1 Build errors in drivers/usb/ip/ (Was: Re: 2.6.16-rc4-mm1)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
>

I'm seeing build errors in drivers/usb/ip/ with gcc 3.4.5 trying to
build a 32bit allyesconfig kernel :

  LD      drivers/usb/ip/vhci-hcd.o
  LD      drivers/usb/ip/stub.o
  LD      drivers/usb/ip/built-in.o
drivers/usb/ip/stub.o(.text+0xc7b): In function `usbip_pack_pdu':
drivers/usb/ip/usbip_common.c:748: multiple definition of `usbip_pack_pdu'
drivers/usb/ip/vhci-hcd.o(.text+0xc7b):drivers/usb/ip/usbip_common.c:748:
first defined here
drivers/usb/ip/stub.o(.text+0xb82): In function `usbip_task_init':
drivers/usb/ip/usbip_common.c:696: multiple definition of `usbip_task_init'
drivers/usb/ip/vhci-hcd.o(.text+0xb82):drivers/usb/ip/usbip_common.c:696:
first defined here
drivers/usb/ip/stub.o(.text+0x5bf): In function `setreuse':
drivers/usb/ip/usbip_common.c:506: multiple definition of `setreuse'
drivers/usb/ip/vhci-hcd.o(.text+0x5bf):drivers/usb/ip/usbip_common.c:506:
first defined here
drivers/usb/ip/stub.o(.text+0xe48): In function `usbip_start_eh':
drivers/usb/ip/usbip_event.c:31: multiple definition of `usbip_start_eh'
drivers/usb/ip/vhci-hcd.o(.text+0xe48):drivers/usb/ip/usbip_event.c:31:
first defined here
drivers/usb/ip/stub.o(.data+0x0): In function `usbip_xmit':
drivers/usb/ip/usbip_common.c:36: multiple definition of `usbip_debug_flag'
drivers/usb/ip/vhci-hcd.o(.data+0x0):drivers/usb/ip/usbip_common.c:36:
first defined here
drivers/usb/ip/stub.o(.text+0xd5f): In function `usbip_recv_xbuff':
drivers/usb/ip/usbip_common.c:803: multiple definition of `usbip_recv_xbuff'
drivers/usb/ip/vhci-hcd.o(.text+0xd5f):drivers/usb/ip/usbip_common.c:803:
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
drivers/usb/ip/stub.o(.text+0xd2e): In function `usbip_event_happend':
drivers/usb/ip/usbip_common.c:788: multiple definition of `usbip_event_happend'
drivers/usb/ip/vhci-hcd.o(.text+0xd2e):drivers/usb/ip/usbip_common.c:788:
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
drivers/usb/ip/stub.o(.text+0xcaa): In function `usbip_recv_iso':
drivers/usb/ip/usbip_common.c:764: multiple definition of `usbip_recv_iso'
drivers/usb/ip/vhci-hcd.o(.text+0xcaa):drivers/usb/ip/usbip_common.c:764:
first defined here
drivers/usb/ip/stub.o(.text+0x0): In function `usbip_xmit':
drivers/usb/ip/usbip_common.c:36: multiple definition of `usbip_xmit'
drivers/usb/ip/vhci-hcd.o(.text+0x0):drivers/usb/ip/usbip_common.c:36:
first defined here
drivers/usb/ip/stub.o(.data+0x4): In function `usbip_xmit':
drivers/usb/ip/usbip_common.c:36: multiple definition of `dev_attr_usbip_debug'
drivers/usb/ip/vhci-hcd.o(.data+0x4):drivers/usb/ip/usbip_common.c:36:
first defined here
drivers/usb/ip/stub.o(.text+0xee5): In function `usbip_stop_eh':
drivers/usb/ip/usbip_event.c:45: multiple definition of `usbip_stop_eh'
drivers/usb/ip/vhci-hcd.o(.text+0xee5):drivers/usb/ip/usbip_event.c:45:
first defined here
drivers/usb/ip/stub.o(.text+0x81f): In function `usbip_dump_header':
drivers/usb/ip/usbip_common.c:597: multiple definition of `usbip_dump_header'
drivers/usb/ip/vhci-hcd.o(.text+0x81f):drivers/usb/ip/usbip_common.c:597:
first defined here
drivers/usb/ip/stub.o(.text+0xa74): In function `usbip_start_threads':
drivers/usb/ip/usbip_common.c:668: multiple definition of `usbip_start_threads'
drivers/usb/ip/vhci-hcd.o(.text+0xa74):drivers/usb/ip/usbip_common.c:668:
first defined here
drivers/usb/ip/stub.o(.text+0xf74): In function `usbip_event_add':
drivers/usb/ip/usbip_event.c:59: multiple definition of `usbip_event_add'
drivers/usb/ip/vhci-hcd.o(.text+0xf74):drivers/usb/ip/usbip_event.c:59:
first defined here
drivers/usb/ip/stub.o(.text+0x53b): In function `setnodelay':
drivers/usb/ip/usbip_common.c:484: multiple definition of `setnodelay'
drivers/usb/ip/vhci-hcd.o(.text+0x53b):drivers/usb/ip/usbip_common.c:484:
first defined here
make[3]: *** [drivers/usb/ip/built-in.o] Error 1
make[2]: *** [drivers/usb/ip] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
