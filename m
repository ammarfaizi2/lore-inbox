Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272295AbTHEAGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272300AbTHEAGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:06:10 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:49366 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272295AbTHEAGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:06:07 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 02:06:04 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: herbert@13thfloor.at, beepy@netapp.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805020604.62be10e6.skraw@ithnet.com>
In-Reply-To: <03080416381704.04444@tabby>
References: <20030804134415.GA4454@win.tue.nl>
	<20030804161657.GA6292@www.13thfloor.at>
	<20030804183545.01b7a126.skraw@ithnet.com>
	<03080416381704.04444@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 16:38:17 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> On Monday 04 August 2003 11:35, Stephan von Krawczynski wrote:
> > On Mon, 4 Aug 2003 18:16:57 +0200
> [...]
> Don't do that. It is too insecure.
> 
> 1. the structure you describe is FRAGILE. Just adding one more entry 
> could/would break the entire structure.
> 
> 2. If you mix security structures like this you WILL get a problem.
> 
> What you do is copy the declassified data to a nonsecure area (also known
> as released data). This way the user can modify internal cata without
> causing the web server potentially catastrophic releases.
> 
> Same with the SQL. Do not attmept to mix sensitive and nonsensitive data
> this way.

Your just kidding, don't you?
Definition of "problem" here is: service got corrupted. It is really of 
_no_ interest if the data that was corrupted is "sensitive" or "nonsensitive",
because the only cure in both versions is rewriting from scratch (and dumping
the server of course).
So your possible downtime is just as big in both ways. And nothing else counts.

> If you web server got hacked, how do you prevent the hack from ADDING
> more links? Or adding SQL injections to other applications...

I don't, because it is simply impossible. If you are root on a webserver
everything is lost, no matter if your data is local or nfs-mounted you can
delete, relink or whatever you like at will.
The only thing you _can't_ do is access data that is not exported to your
hacked system. And that's exactly what I am trying to do: don't give any more
data away than absolutely necessary.

Regards,
Stephan
