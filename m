Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUBMShi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbUBMShi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:37:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11220 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267164AbUBMSeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:34:19 -0500
Date: Fri, 13 Feb 2004 10:33:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>
cc: torvalds@osdl.org, mingo@elte.hu, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, drepper@redhat.com
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-ID: <38670000.1076697235@flay>
In-Reply-To: <20040215062544.5e554a61.ak@suse.de>
References: <1076384799.893.5.camel@gaston><Pine.LNX.4.58.0402100814410.2128@home.osdl.org><20040210173738.GA9894@mail.shareable.org><20040213002358.1dd5c93a.ak@suse.de><20040212100446.GA2862@elte.hu><Pine.LNX.4.58.0402120833000.5816@home.osdl.org><20040213032604.GI25499@mail.shareable.org> <20040215062544.5e554a61.ak@suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Sunday, February 15, 2004 06:25:44 +0100 Andi Kleen <ak@suse.de> wrote:

> On Fri, 13 Feb 2004 03:26:04 +0000
> Jamie Lokier <jamie@shareable.org> wrote:
> 
>> Linus Torvalds wrote:
>> > One option is to mark the brk() VMA's as being grow-up (which they are), 
>> > and make get_unmapped_area() realize that it should avoid trying to 
>> > allocate just above grow-up segments or just below grow-down segments. 
>> > That's still something of a special case, but at least it's not "magic" 
>> > any more, now it's more of a "makes sense".
>> 
>> That reminds me.  What happens when grow-down stack VMAs finally bump
>> into another VMA.  Is there an unmapped guard page retained to segfault
>> the program, or does the program silently start overwriting the VMA it
>> bumped into?
> 
> In the standard kernel it silently overwrites, but in 2.4-aa there was a patch forever
> that adds a guard page.

Do you happen to remember the name of the patch? Hunting in Andrea's tree
isn't always easy ;-)

M.

