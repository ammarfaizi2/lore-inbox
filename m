Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277820AbRJRQxM>; Thu, 18 Oct 2001 12:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277825AbRJRQww>; Thu, 18 Oct 2001 12:52:52 -0400
Received: from intranet.resilience.com ([209.245.157.33]:6315 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S277815AbRJRQwr>; Thu, 18 Oct 2001 12:52:47 -0400
Mime-Version: 1.0
Message-Id: <p05100303b7f4b90ab170@[207.213.214.37]>
In-Reply-To: <20011018110826.A22339@taral.net>
In-Reply-To: <Pine.LNX.4.21.0110171617460.15653-100000@marty.infinity.powertie.org>
 <20011018110826.A22339@taral.net>
Date: Thu, 18 Oct 2001 09:52:15 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:08 AM -0500 10/18/01, Taral wrote:
>On Wed, Oct 17, 2001 at 04:52:29PM -0700, Patrick Mochel wrote:
>>  When a suspend transition is triggered, the device tree is walked first to
>>  save the state of all the devices in the system. Once this is complete, the
>>  saved state, now residing in memory, can be written to some non-volatile
>>  location, like a disk partition or network location.
>>
>>  The device tree is then walked again to suspend all of the devices. This
>>  guarantees that the device controlling the location to write the state is
>>  still powered on while you have a snapshot of the system state.
>
>Aha! A much nicer solution to the problem the ACPI people are having
>with suspend/resume (ordering problems).

What happens to state changes between the first and second traversal 
of the device tree?
-- 
/Jonathan Lundell.
