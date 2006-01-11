Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWAKSpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWAKSpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWAKSpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:45:38 -0500
Received: from web34112.mail.mud.yahoo.com ([66.163.178.110]:40824 "HELO
	web34112.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932542AbWAKSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:45:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rf/HjHhVpxgSJ1tZriD2LeLxBhbJvfCrfEV3Z6AITrxsxXlFmymlFnWUdWsvph6KPYetC+a0rNAPklewqJF3qEB2iv5nE0dwP18i4pjZOFZzu012cDBEq3IMtqbIFi0CcgewwMfTWtdPQo5A7kjegTGBeK/1wweHjK/SMKDq4yc=  ;
Message-ID: <20060111184532.42618.qmail@web34112.mail.mud.yahoo.com>
Date: Wed, 11 Jan 2006 10:45:32 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: Is user-space AIO dead?
To: David Lloyd <dmlloyd@tds.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601111223210.14191@tomservo.workpc.tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Lloyd <dmlloyd@tds.net> wrote:
> Wouldn't nonblocking I/O on regular files be nice?

Yes it could be.  As I understand it, regular file writes (not O_DIRECT) are only to the page
cache and only block when there is memory pressure (so it is more of a throttle).

Reads, on the other hand, could be quite handy.  What might be very cool is if there were a way to
mmap and start faulting in the pages in the background, and get notified as they complete - or
when all the faulting is done.

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
