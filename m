Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422754AbWGNUKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422754AbWGNUKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWGNUKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:10:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:19353 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422754AbWGNUKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:10:54 -0400
Message-ID: <44B7FA09.5070803@zytor.com>
Date: Fri, 14 Jul 2006 13:09:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com> <200607121652.21920.ak@suse.de> <m1lkqyc00d.fsf@ebiederm.dsl.xmission.com> <200607121808.26555.ak@suse.de> <m1ac7ebx0v.fsf@ebiederm.dsl.xmission.com> <20060712112432.0cd5996f@dxpl.pdx.osdl.net> <1152734309.3217.71.camel@laptopd505.fenrus.org> <20060713005218.GK9040@thunk.org>
In-Reply-To: <20060713005218.GK9040@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Wed, Jul 12, 2006 at 09:58:29PM +0200, Arjan van de Ven wrote:
>> On Wed, 2006-07-12 at 11:24 -0700, Stephen Hemminger wrote:
>>> What is the motivation behind killing the sys_sysctl call anyway?
>>> Sure its more ugly esthetically but it works.
>> it "works" but the thing is that the number space is NOT stable, and as
>> such it's a really bad ABI
> 
> To be fair, the older, "base" numbers are actually stable, such as
> what glibc is depending on, have in practice been quite stable.  It's
> only the newer fields that tend to be unstable.
> 
> But that means we can afford to do an orderly migration away from it;
> it's not something that has to be urgently done within a few weeks or
> even a few months.
> 

Another alternative would be to publish a limited set of sysctl numbers 
that will be maintained forever.

	-hpa
