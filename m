Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVCXOvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVCXOvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVCXOvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 09:51:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33413 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262509AbVCXOvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 09:51:00 -0500
Date: Thu, 24 Mar 2005 08:50:50 -0600
From: Michael Raymond <mraymond@sgi.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User Level Interrupts
Message-ID: <20050324085047.F110444@goliath.americas.sgi.com>
References: <20050323103832.A108873@goliath.americas.sgi.com> <20050323145738.A29828@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050323145738.A29828@unix-os.sc.intel.com>; from ashok.raj@intel.com on Wed, Mar 23, 2005 at 02:57:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I did the test you suggested.  The turning-on and turning-off appeared
to work but our SN Hub ASIC still sent interrupts to the specific CPU.
    I looked at my code again and from your description of Hotplug I do not
see any conflicts.
    		  				Thanks,
    		  					Michael

On Wed, Mar 23, 2005 at 02:57:39PM -0800, Ashok Raj wrote:
> Hi Michael
> 
> have you thought about how this infrastructure would play well with 
> existing CPU hotplug code for ia64?
> 
> Once you return to user mode via the iret, is it possible that user mode
> thread could get switched due to a pending cpu quiese attempt to remove
> a cpu? (Current cpu removal code would bring the entire system to knees
> by scheduling a high priority thread and looping with intr disabled, until the
> target cpu is removed)
> 
> the cpu removal code would also attempt to migrate user process to another cpu,
> retarget interrupts to another existing cpu etc. I havent tested the hotplug
> code on sgi boxes so far. (only tested on some hp boxes by Alex Williamson
> and on tiger4 boxes so far)
> 
> Cheers,
> ashok

-- 
Michael A. Raymond              Office: (651) 683-3434
Core OS Group                   Real-Time System Software
