Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTJAEyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 00:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTJAEyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 00:54:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:19657 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261909AbTJAEyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 00:54:14 -0400
Date: Tue, 30 Sep 2003 21:55:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Murray J. Root" <murrayr@brain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Message-Id: <20030930215512.1df59be3.akpm@osdl.org>
In-Reply-To: <20031001032238.GB1416@Master>
References: <20031001032238.GB1416@Master>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Murray J. Root" <murrayr@brain.org> wrote:
>
> The render finishes in the same 30 minutes, then oowriter starts.
>  oowriter takes about 3 seconds to load if no rendering is going on.

OpenOffice uses sched_yield() in strange ways which causes it to
get hopelessly starved on 2.6 kernels.  I think RH have a fixed version,
but I don't know if that has propagated into the upstream yet.

So...  Don't worry about OpenOffice too much.  Is the problem reproducible
with other applications?
