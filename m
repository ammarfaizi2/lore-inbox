Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267702AbSIRRhS>; Wed, 18 Sep 2002 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbSIRRhS>; Wed, 18 Sep 2002 13:37:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55632 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267702AbSIRRhR>; Wed, 18 Sep 2002 13:37:17 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: hadi@cyberus.ca, akpm@digeo.com, manfred@colorfullife.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <3D87A59C.410FFE3E@digeo.com>
	<Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca>
	<20020917.180014.07882539.davem@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Sep 2002 11:27:34 -0600
In-Reply-To: <20020917.180014.07882539.davem@redhat.com>
Message-ID: <m1hegnky2h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: jamal <hadi@cyberus.ca>
>    Date: Tue, 17 Sep 2002 20:57:58 -0400 (EDT)
>    
>    I am not so sure with that 6% difference there is no other bug lurking
>    there; 6% seems too large for an extra two PCI transactions per packet.
> 
> {in,out}{b,w,l}() operations have a fixed timing, therefore his
> results doesn't sound that far off.
????

I don't see why they should be.  If it is a pci device the cost should
the same as a pci memory I/O.  The bus packets are the same.  So things like
increasing the pci bus speed should make it take less time.

Plus I have played with calibrating the TSC with outb to port
0x80 and there was enough variation that it was unuseable.  On some
newer systems it would take twice as long as on some older ones.

Eric
