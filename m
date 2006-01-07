Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWAGGip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWAGGip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 01:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965343AbWAGGip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 01:38:45 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:44301 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964859AbWAGGio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 01:38:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ItuNuGZzdIrDYAbCbG/ATjPMS0cOvIxj9iWlbBelVDrnLC+TcbR1dukSa2JRSF1LDeAxWvYjM/Sxudp15Fq92d+nKgqf13OzW79NUh/cnsmUjEKwLUaOqzhmaVGVMLduMYBb21RQqTOE8mhtEN/ARsOaG5hilxIj9uLVYWlhxJI=
Message-ID: <86802c440601062238r1b304cd4j2d9c8e14a8324618@mail.gmail.com>
Date: Fri, 6 Jan 2006 22:38:43 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@muc.de>, ebiederm@xmission.com
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
In-Reply-To: <86802c440601061832m4898e20fw4c9a8360e85cfa17@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CB@ssvlexmb2.amd.com>
	 <86802c440601061832m4898e20fw4c9a8360e85cfa17@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

in the smpboot.c, why you need to use 0x467, and 0x469 ....

        Dprintk("1.\n");
        *((volatile unsigned short *) phys_to_virt(0x469)) = start_rip >> 4;
        Dprintk("2.\n");
        *((volatile unsigned short *) phys_to_virt(0x467)) = start_rip & 0xf;
        Dprintk("3.\n");

YH
