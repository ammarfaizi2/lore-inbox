Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278041AbRKAEmD>; Wed, 31 Oct 2001 23:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277966AbRKAElx>; Wed, 31 Oct 2001 23:41:53 -0500
Received: from zok.sgi.com ([204.94.215.101]:51398 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277949AbRKAEln>;
	Wed, 31 Oct 2001 23:41:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cache colour task_structs 
In-Reply-To: Your message of "01 Nov 2001 02:43:20 BST."
             <p73668vqn9j.fsf@amdsim2.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Nov 2001 15:42:12 +1100
Message-ID: <28006.1004589732@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Nov 2001 02:43:20 +0100, 
Andi Kleen <ak@suse.de> wrote:
>You could do that even today (without slab task_struct) by using a 
>random/coloured at fork time value for esp0.  This could just be a static
>colour counter that is subtracted.
>
>Just don't forget to teach ptrace and proc WCHAN and oops printing about it; 
>they currently use hardcoded stack offsets. It'll also likely break kdb.

Should not affect kdb.  It uses current->esp0 for accessing user regs.
Back trace unwinds the stack until it hits a 0 return address, it just
not check for esp0.

