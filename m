Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTGATc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTGATc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:32:58 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62223 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263398AbTGATc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:32:57 -0400
Date: Tue, 1 Jul 2003 21:53:23 +0200
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Fredrik Tolf <fredrik@dolda2000.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: PTY DOS vulnerability?
Message-ID: <20030701195323.GA15483@hh.idb.hist.no>
References: <200306301613.11711.fredrik@dolda2000.cjb.net> <03070106574900.01125@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03070106574900.01125@tabby>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 06:57:49AM -0500, Jesse Pollard wrote:
> 
> One problem is that ptys are not just "used by the user". Every terminal
> window opened uses a pty. As does a network connection.
> 
> As does "expect" - which is less visible to the user since it is intended
> to be invisible.
> 
> The real question is "how many PTYs should a single user have?"
> Which then prompts the question "How many concurrent users should there be?"
> 
> second, just providing a user limit doesn't prevent a denial of service..
> Just have more connections than ptys and you are in the same situation.

Isn't this something a improved sshd could do?  I.e. if the
connection using up the last (or one of the last) pty's logs
in as non-root - just kill it.

