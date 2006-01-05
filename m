Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWAEPRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWAEPRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWAEPRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:17:36 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:43690 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751392AbWAEPRf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:17:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e4P4cjg2SD7Oj4G+LGM1H+lZNSWR5kxm5Pl1GbBBx5C/F4G7S9swgOq4JMVBakhcawdhjFHc9ggLn4ykm3VQ+WeUnl+7Esmht7gi0ekM6gby9WqKgkzlPeT+Goumx4NLb7L5FVoQ5NYTB/Byyh9ANNEQwpPWFf970fqXwpOG0Pk=
Message-ID: <9a8748490601050717r655773b9p823b36f19c728fc2@mail.gmail.com>
Date: Thu, 5 Jan 2006 16:17:35 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: oops pauser.
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601051201200.21555@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105045212.GA15789@redhat.com>
	 <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
	 <20060105103339.GG20809@redhat.com>
	 <Pine.LNX.4.61.0601051201200.21555@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >See the other patch I sent which halves the amount of lines needed
> >for a backtrace on i386 (like x86-64 uses). This helps too.
> >
> .oO( Compress the oops, encode it base64 and display that instead )Oo. :-)
>
Not really something we want to do at Oops time and even if the kernel
was in a sane enough state to actually do it you've just increased the
amount of work needing to be done to decode the Oops by everyone
recieving/wanting to read it.

I think a better idea is to try and move things around so the most
useful pieces of information are on the last lines of the Oops output
(most likely to not have scrolled off the screen) and also work to
elliminate lines that are not really useful/helpful and maybe try to
cram more info from multiple short lines into a single line.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
