Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272321AbTHEATs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272331AbTHEATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:19:47 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:32727 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272321AbTHEATl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:19:41 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 02:19:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrew Pimlott <andrew@pimlott.net>
Cc: aia21@cam.ac.uk, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805021938.7e547cce.skraw@ithnet.com>
In-Reply-To: <20030804225819.GA23512@pimlott.net>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<20030804134415.GA4454@win.tue.nl>
	<20030804155604.2cdb96e7.skraw@ithnet.com>
	<Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk>
	<20030804165002.791aae3d.skraw@ithnet.com>
	<20030804225819.GA23512@pimlott.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 18:58:19 -0400
Andrew Pimlott <andrew@pimlott.net> wrote:

> On Mon, Aug 04, 2003 at 04:50:02PM +0200, Stephan von Krawczynski wrote:
> > There is a flaw in this argument. If I am told that mount --bind
> > does just about what I want to have as a feature then these
> > applictions must have the same problems already (if I mount
> > braindead). So an implementation in fs cannot do any _additional_
> > damage to these applications, or not?
> 
> There is a flaw in this flaw.  :-)
> 
> /tmp# mkdir a
> /tmp# mkdir a/b
> /tmp# mkdir a/c
> /tmp# mount --bind a a/b
> /tmp# ls a  
> b  c
> /tmp# ls a/b
> b  c
> /tmp# ls a/b/b/
> /tmp#
> 
> It is enlightening in this regard to consider the difference between
> using unix /etc/fstab and Hurd translators to manage your namespace.
> 
> In preparing this example, I discovered that find and ls -R already
> have hard-link cycle "protection" built in, so they are broken in
> the presence of bind mounts.  :-(

Ok, so now we are at: application programmer expected hardlinks to exist, but
fs programmer says they won't because they break existing applications.
Now the discussion gets real interesting ;-)

Regards,
Stephan

