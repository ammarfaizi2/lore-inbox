Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272337AbTHEAKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272339AbTHEAKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:10:54 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:2775 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272337AbTHEAKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:10:48 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 02:10:46 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Randolph Bentson <bentson@holmsjoen.com>
Cc: jesse@cats-chateau.net, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805021046.06008535.skraw@ithnet.com>
In-Reply-To: <20030804160009.B3751@grieg.holmsjoen.com>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<03080416092800.04444@tabby>
	<20030805003210.2c7f75f6.skraw@ithnet.com>
	<20030804160009.B3751@grieg.holmsjoen.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 16:00:09 -0700
Randolph Bentson <bentson@holmsjoen.com> wrote:

> On Tue, Aug 05, 2003 at 12:32:10AM +0200, Stephan von Krawczynski wrote:
> > And in just the same way fs could provide a mode bit saying "hi, I am a
> > hardlink", and tar can then easily provide option number 1345 saying
> > "stay away from hardlinks".
> 
> Perhaps not a bit, but rather another enumerated value in the type field
> of an inode.  (Are there any values left?)
> 
> Ok, lets consider this.  Suppose that /a/b and /a/c both refer to the same
> directory, where /a/b is a traditional link, but /a/c is a "hardlink".
> 
> What happens when one executes 'rmdir /a/b'?  Does the directory it
> references disappear?  If not, how would tar ever find it?  (I have
> this vision of a disk full of these hardlink-only directories which
> tar and perhaps fsck cannot find.)

The setup you describe is exactly the reason why I suggested elsewhere (in a
private discussion) to single-link all directory entries pointing to the same
directory in a list. In case of deletion of the "main" entry, the "main" simply
can walk on to the next (former) hardlink, if there are any left the tree is
deleted completely. That's it.

Regards,
Stephan

