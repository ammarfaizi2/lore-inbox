Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWGJNFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWGJNFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWGJNFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:05:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9696 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161065AbWGJNFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:05:41 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060710124540.GA742@phoenix>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com>
	 <1152377434.3120.69.camel@laptopd505.fenrus.org>
	 <200607082125.12819.rjw@sisk.pl>
	 <1152387552.3120.89.camel@laptopd505.fenrus.org>
	 <44B219CC.4010409@zurich.ibm.com>
	 <1152523109.4874.11.camel@laptopd505.fenrus.org>
	 <20060710124540.GA742@phoenix>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 15:05:38 +0200
Message-Id: <1152536739.4874.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 08:45 -0400, Thomas Tuttle wrote:
> First, let me say, I've gotten both swsusp and suspend2 to work, but
> I've had better luck with hardware under suspend2, and reading and
> writing the image was faster under suspend2.
> 
> On July 10 at 05:18 EDT, Arjan van de Ven hastily scribbled:
> > As I said... if that is the case then it'd be easy to first merge "the
> > right basics", get that solid, and THEN add the features. So far I've
> > not seen that happen.
> 
> So, you mean like merge just the freezer mods (if needed), and the
> suspend2 core, and then add the encryption/compression/filewriter/userui
> stuff separately?

yes. If suspend2 core is really better, that should be an improvement
already, without the additional complexity of the
encryption/compression/etc stuff. Get that merged, get it out there,
once a lot more people use it there may also be a lot more bug reports,
which are easier to fix in a low complexity environment. When that is
done, the encryption/compression/etc can be merged incrementally and
reviewed incrementally, on top of a stable basis. 

When something is as tricky as suspend, the primary goal should be to
avoid complexity until things are stable. The suspend2 side of the house
seems to suggest the kernel.org state currently is not (I'm not going to
stick my hand in the hornest nest and agree or disagree), and if that's
indeed the case then just fixing that bit should be paramount, without
adding "unneeded" complexity at the same time.

This doesn't mean that I don't like any of those features. Don't get me
wrong there. It just means that I'm saying that adding those as a second
phase instead makes a whole lot of sense to me, just to keep the problem
clean. 

