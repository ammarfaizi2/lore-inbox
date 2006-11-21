Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031410AbWKUUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031410AbWKUUeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031411AbWKUUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:34:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52118 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1031410AbWKUUeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:34:21 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/pid.c: remove two unused exports
References: <20061121194155.GH5200@stusta.de>
Date: Tue, 21 Nov 2006 13:33:30 -0700
In-Reply-To: <20061121194155.GH5200@stusta.de> (Adrian Bunk's message of "Tue,
	21 Nov 2006 20:41:55 +0100")
Message-ID: <m18xi4v8th.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch removes two unused exports.

Ok.  Could we hold off on this a little bit?

In general I think this is sane, but looking through my pending
patches I have at least one patch that uses find_get_pid from
a modular context.

The general issue is that drivers and thus most modules should
not be aware of pid_t values.  However there do seem to be a few
rare exceptions.

Eric
