Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbTAQQYG>; Fri, 17 Jan 2003 11:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbTAQQYG>; Fri, 17 Jan 2003 11:24:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18744 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267582AbTAQQYF>; Fri, 17 Jan 2003 11:24:05 -0500
To: John Bradford <john@grabjohn.com>
Cc: jgarzik@pobox.com (Jeff Garzik), Herman@wirelessnetworksinc.com,
       linux-kernel@vger.kernel.org
Subject: Re: Open source hardware
References: <200301162225.h0GMP0YI003249@darkstar.example.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Jan 2003 09:32:43 -0700
In-Reply-To: <200301162225.h0GMP0YI003249@darkstar.example.net>
Message-ID: <m165sng2j8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> Do you know of anybody who has actually made a prototype board from
> any of these CPU designs?  Is my idea of running a lot of simple CPUs
> together fundamentally flawed, or is it possible to overcome the
> inefficiencies of SMP, if the CPUs are designed for it from the ground
> up?

The fundamental problem is not inefficiencies of SMP.  But rather
there are some tasks that simply do not parallelize well.  Big
supercomputer kinds of applications that require a lot of number
crunching usually benefit from multiple cpus.  But small every day
applications don't.  The only applications that scale perfectly with
the number of cpus are the embarrassingly parallel ones, in which no
communication is involved between the various subtasks.

This is not to say an elegant design might not get there, AMD is
trying for that.  But simple brute force will certainly not get you
there.

Eric
