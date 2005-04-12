Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVDLWiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVDLWiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVDLWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:34:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6132 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262574AbVDLWdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:33:39 -0400
Subject: RE: FUSYN and RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A02FD4673@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A02FD4673@orsmsx407>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113345199.6389.30.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Apr 2005 15:33:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 15:26, Perez-Gonzalez, Inaky wrote:

> You should not need any of this if your user space mutexes are a
> wrapper over the kernel space ones. The kernel handles everything
> the same and there is no need to take care of any special cases or
> variations [other than the ones imposed by the wrapping].


The problem situation that I'm thinking of is when a task gets priority
boosted by Fusyn , then gets priority boosted by an RT Mutex. In that
situation, when the RT mutex demotes back to task->static_prio it will
be lower than the priority that Fusyn has given the task (potentially). 
I don't think that's handled in the kernel anyplace, is it?

Daniel

