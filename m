Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUEAQnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUEAQnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUEAQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 12:43:50 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:59060 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261313AbUEAQnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 12:43:49 -0400
Message-ID: <4093D3C7.5040109@backtobasicsmgmt.com>
Date: Sat, 01 May 2004 09:43:51 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com> <s5ghdv0i8w4.fsf@patl=users.sf.net>
In-Reply-To: <s5ghdv0i8w4.fsf@patl=users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick J. LoPresti wrote:

> So there is no way to load this hardware driver and wait until it
> either binds or fails to bind to its associated hardware?  That seems
> like a bad bug in the design...

You are wanting to load a driver for a completely-hotplug-capable 
subsystem but treat as if it was not? What will your package do if the 
user does not have the keyboard plugged in when the module gets loaded?

IMHO you should use the hotplug infrastructure and do this properly; 
load the module, and then sleep/wait until you get a hotplug event 
telling you that a keyboard has been found.
