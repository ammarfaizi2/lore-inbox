Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316892AbSGSQbL>; Fri, 19 Jul 2002 12:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSGSQbL>; Fri, 19 Jul 2002 12:31:11 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:9864 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S316892AbSGSQbK>;
	Fri, 19 Jul 2002 12:31:10 -0400
Subject: Re: more thoughts on a new jail() system call
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1027095858.2634.48.camel@zaphod>
References: <1026959170.14737.102.camel@zaphod> 
	<ah7m2r$3cr$1@abraham.cs.berkeley.edu>  <1027095858.2634.48.camel@zaphod>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jul 2002 12:34:01 -0400
Message-Id: <1027096442.2635.54.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 12:24, Shaya Potter wrote:
> On Thu, 2002-07-18 at 20:21, David Wagner wrote:
> > >sys_syslog) NOT SURE (probably jailed away)
> > 
> > sys_syslog touches a global shared resource, hence
> > should probably be denied to jailed processes.
> 
> or virtualized.

forget that, stupid, sys_syslog only deals with printk buffer, not
normal syslogd.  so lock it away from jails, system deals with it
normally.

