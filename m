Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSGTAbJ>; Fri, 19 Jul 2002 20:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSGTAbJ>; Fri, 19 Jul 2002 20:31:09 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48662 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317258AbSGTAbI>; Fri, 19 Jul 2002 20:31:08 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200207200032.g6K0Wwk11011@devserv.devel.redhat.com>
Subject: Re: [PATCH] strict VM overcommit
To: bunk@fs.tum.de (Adrian Bunk)
Date: Fri, 19 Jul 2002 20:32:57 -0400 (EDT)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <Pine.NEB.4.44.0207182359300.17300-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Jul 19, 2002 12:08:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> How is assured that it's impossible to OOM when the amount of memory
> shrinks?
> 
> IOW:
> - allocate very much memory
> - "swapoff -a"

Make swapoff -a return -ENOMEM

I've not done this on the basis that this is root specific stupidity and 
generally shouldnt be protected against
