Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264793AbTFBRNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbTFBRNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:13:19 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:49844 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264793AbTFBRNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:13:17 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306021725001.7676-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306021725001.7676-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1054567968.3545.26.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 11:32:49 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.4, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 11:25, Ingo Molnar wrote:
> On 2 Jun 2003, Arjan van de Ven wrote:
> 
> > given that audio mixing also happens in userspace it doesn't sound that
> > weird..... niceing wine gives the userspace sound mixer more cpu time :)
> 
> well, this depends on the circumstances. Normally the mixing shouldnt take
> all that much CPU time, and thus the audio server thread should in theory
> be quite interactive.

I think this may be because wine uses a client/server model.  There is
the wine client which runs the actual applications, but they seem to
share the core wineserver process which seems to be responsible for
actually mixing and generating the sound output.  Renicing the 'wine'
(frontend) process give the 'wineserver' (backend) process more CPU time
to actually get the sound out.

I don't know much about WINE, so all of that is only a guess as to how
it appears to be working to me.  I guess I should go read up on it.

Later,
Tom


