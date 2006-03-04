Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWCDFfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWCDFfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 00:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWCDFfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 00:35:39 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:18966 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751035AbWCDFfi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 00:35:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jU1KbThkAfX8TKoqiF3b57fIukb7qkQzt2GsbuF30MKmbfgUU2jNMuixWncMIadbV5VuzZ3GYt8QMBlTJ+MWmuaIlrgLUOZuHVZAIOyJTpf/m4+pMoIUqNlV7Faz9JZy4/ozhH+EuK5c0J0Mu8uc76UQI+n3aHXP/6/3cB6YDrk=
Message-ID: <35fb2e590603032135g19351068veee4e0187dbe629a@mail.gmail.com>
Date: Sat, 4 Mar 2006 05:35:37 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: roland <devzero@web.de>
Subject: Re: is there a COW inside the kernel ?
Cc: "Kevin Corry" <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Jeff Dike" <jdike@addtoit.com>, agk@redhat.com,
       jengelh@linux01.gwdg.de
In-Reply-To: <04cd01c63f09$a007a930$0200000a@aldipc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <043101c63e9c$86e9d710$0200000a@aldipc>
	 <200603030828.59567.kevcorry@us.ibm.com>
	 <04cd01c63f09$a007a930$0200000a@aldipc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, roland <devzero@web.de> wrote:

> i think i will take a closer look on device-mapper, but i'm unsure if it`s
> perfectly suited.

It looks to me that you want to use something more like unionfs with
COW/whiteout mode - there's an implementation based on FUSE available
but I've not really looked at it. Obviously you might just want
something in mainline, in which case you're limited to the FUSE idea
or one of the others already suggested.

> what about merging a cow-dev/file back to the r/o-dev/file ?

This is why I suggest you look at the above.

Jon.
