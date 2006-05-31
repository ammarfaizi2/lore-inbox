Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWEaWq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWEaWq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWEaWqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:46:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21451 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964812AbWEaWqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:46:55 -0400
Date: Thu, 1 Jun 2006 00:46:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@google.com>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <20060531221242.GA5269@elte.hu>
Message-ID: <Pine.LNX.4.64.0606010026160.17704@scrub.home>
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org>
 <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org>
 <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org>
 <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org>
 <20060531221242.GA5269@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jun 2006, Ingo Molnar wrote:

> on one side, the -mm kernel is about showcasing new code and finding
> bugs in them as fast as possible. Having new debugging options enabled
> by default is an important part of the testing effort. Users will care
> more about having no crashes than about having 0.5% more performance in
> select benchmarks.
> 
> on the other side, you obviously dont want a 0.5% overhead for select 
> benchmarks, as that would mess up the history! A very fair and valid 
> position too.
> 
> but one side has to give, we cant have both.

As I mentioned before, please keep these defaults as a -mm-only patch, 
Giving them testing in -mm is fine, but defaults are already way too much 
abused as is. The default rule should be to enable an option explicitly, 
if it's needed, it should not be auto-enabled, because its author likes 
it so much. Using a "default y" should be close to hiding the option via 
CONFIG_EMBEDDED or some other option and the default should not differ 
between hidden and visible state, e.g.:

config FOO
	bool "foo" if BAR
	default y

bye, Roman
