Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTEEJBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 05:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTEEJBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 05:01:55 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:47324 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S262110AbTEEJBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 05:01:54 -0400
Date: Mon, 5 May 2003 16:01:25 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Terje Eggestad <terje.eggestad@scali.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052122784.2821.4.camel@pc-16.office.scali.no>
Message-ID: <Pine.SGI.4.10.10305051545480.8168393-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 May 2003, Terje Eggestad wrote:

> Now that it seem that all are in agreement that the sys_call_table
> symbol shall not be exported to modules, are there any work in progress

No, I disagree.

> to allow modules to get an event/notification whenever a specific
> syscall is being called?

I need this table to _call_ any of system calls that available to the
process, nothing else. Sys_call_table can be placed in .rodata section
(there was patch a few days ago) to prevent modification from modules.
But why module should not have ability to call any function which is
available from user space?

Almost all of my third-party drivers are broken by this.
What is worse, redhat "backported" this "feature" to their 2.4
patched kernels and now I should distinguish 2.4 and "redhat 2.4"
in my compatibility headers.

