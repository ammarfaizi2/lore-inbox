Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVBAJKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVBAJKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVBAJKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:10:08 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:2442 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261933AbVBAJHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:07:52 -0500
Date: Tue, 1 Feb 2005 10:07:47 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] "biological parent" pid
In-Reply-To: <E1CvlZk-0007D3-00@calista.eckenfels.6bone.ka-ip.net>
Message-ID: <Pine.LNX.4.53.0502010945480.23883@gockel.physik3.uni-rostock.de>
References: <E1CvlZk-0007D3-00@calista.eckenfels.6bone.ka-ip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Bernd Eckenfels wrote:

> In article <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de> you wrote:
> > I am not aware of concepts in Linux or other unices that apply to this
> > case.
> 
> Normal process accounting.

Sure. That's what the patch was made for. Or do you have anything else
in mind than BSD accounting?

> If you want to keep the pid of the bio-parent, you also need to keep the
> start-time to make it unique.

Yes, that's what I wrote: A process would be uniquely identified by the
(btime, pid) pair, in terms of BSD accounting field names. Or
(start_time, pid), if we use the names of task_struct members.

> Better would be to have a all-time-unqiue process handle.

Yes, but that would need new infrastructure. So instead of assigning new
64 bit process handles, we can just just that pair of 32 bit variables.

> But I think it is better to not have that field, but use
> audit logs. That is especially needed if you want to track chains, because
> it doesnt help you to know the bio parent if you have no idea what that was.

That's the kind of comment I was actually seeking - maybe what I'm trying 
is not really worth because anyone interested in its reliability and 
security would use auditing anyways.

But still it might be useful for 'home use', because I do have an idea of 
what the parent was if I keep the BSD accounting records.
