Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVCWRGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVCWRGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVCWRGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:06:32 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:29177 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261780AbVCWRF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:05:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=My7z4gmTDboR0Z6S8oJ7mkn3IKRdrOArMoDtvMofivR2EhKngyIWPR/kVq6Dci0oj3ahYO0u1S/CwheTAGREFP4p5H922MlDtE8o0Cp2dk4NB3SFoPWZLVxx50hbOJQzQHDQqoDVXNfnrjzijhHr/4IpkfAqjfY17VDHcvwoKfs=
Message-ID: <9cde8bff05032309056c9643a7@mail.gmail.com>
Date: Thu, 24 Mar 2005 02:05:28 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Natanael Copa <mlists@tanael.org>
Subject: Re: forkbombing Linux distributions
Cc: "Hikaru1@verizon.net" <Hikaru1@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1111586058.27969.72.camel@nc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com>
	 <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com>
	 <1111586058.27969.72.camel@nc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 14:54:18 +0100, Natanael Copa <mlists@tanael.org> wrote:
> On Wed, 2005-03-23 at 22:04 +0900, aq wrote:
> > On Wed, 23 Mar 2005 13:37:38 +0100, Natanael Copa <mlists@tanael.org> wrote:
> > > > > This is an example of a program in C my friends gave me that forkbombs.
> > > > > My previous sysctl.conf hack can't stop this, but the /etc/limits solution
> > > > > enables the owner of the computer to do something about it as root.
> > > > >
> > > > > int main() { while(1) { fork(); } }
> > >
> > > I guess that "fork twice and exit" is worse than this?
> >
> > you meant code like this
> >
> > int main() { while(1) { fork(); fork(); exit(); } }
> >
> >  is more harmful ? I dont see why (?)
> 
> Because the parent disappears. When things like killall tries to kill
> the process its already gone but there are 2 new with new pids.
> 

are you sure? the above forkbomb will stop quickly after just several
spawns because of exit().

I agree that make kernel more restrictive by default is a good approach.

thank you,
aq
