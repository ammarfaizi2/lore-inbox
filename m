Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUFVRId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUFVRId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUFVRHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:07:07 -0400
Received: from tantale.fifi.org ([216.27.190.146]:49802 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S264895AbUFVQxF (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:53:05 -0400
To: David Balazic <david.balazic@hermes.si>
Cc: "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: Re: Disk copy, last sector problem
References: <600B91D5E4B8D211A58C00902724252C01BC0700@piramida.hermes.si>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 22 Jun 2004 09:52:54 -0700
In-Reply-To: <600B91D5E4B8D211A58C00902724252C01BC0700@piramida.hermes.si>
Message-ID: <87smcncz6h.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic <david.balazic@hermes.si> writes:

> Hi!
> 
> cat /dev/hda > /dev/hdc
> 
> This would not copy the entire disk as expected, but miss the last sector if
> the number of
> sectors on hda is odd. ( I used "cat" becasue it has the simplest syntax,
> "dd" and other behave the same ).
> Has this been fixed recently ?
> What about suppport of other sectors sizes, like 8kb ?

Have you tried setting the device block size to its sector size?

  blockdev --setbsz $(blockdev --getss /dev/...) /dev/...

Phil.
