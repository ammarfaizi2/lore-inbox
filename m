Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTLLMuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 07:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTLLMuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 07:50:54 -0500
Received: from smtpde03.sap-ag.de ([155.56.68.171]:4006 "EHLO
	smtpde03.sap-ag.de") by vger.kernel.org with ESMTP id S264557AbTLLMuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 07:50:52 -0500
To: desrt <desrt@desrt.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmem_file_setup creating SYSV00000000 files in (ext3) root
 filesystem
References: <1070682344.17941.6.camel@peloton.desrt.ca>
From: Christoph Rohland <cr@sap.com>
Organisation: Development SAP J2EE Engine
Date: Fri, 12 Dec 2003 13:50:21 +0100
In-Reply-To: <1070682344.17941.6.camel@peloton.desrt.ca> (desrt@desrt.ca's
 message of "Fri, 05 Dec 2003 22:45:44 -0500")
Message-ID: <ovllpiurn6.fsf@sap.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN,
 cygwin32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On Fri, 05 Dec 2003, desrt@desrt.ca wrote:
> the problem is caused by the fact that the checks that
> shmem_file_setup does to determine the location of the mountpoint of
> tmpfs fail to take into account the effect of pivot_root.

No, see below.

> and somehow as a result, this happens:
> peloton:/proc# grep deleted */maps
> 17923/maps:4201a000-4207a000 rw-s 00000000 00:04 21233690  
> /SYSV00000000 (deleted)
> [many many many lines follow]
> 
> if you have any advice or can confirm to me that this is actually a
> bug in the kernel, please reply.  i'm not on the list.

It's not a bug. It is simply a display issue designed in this
way. These names are artificial names which were never linked to a real
directory entry. So they end up displayed in this way. But they are
not connected to your root filesystem.

Greetings
		Christoph


