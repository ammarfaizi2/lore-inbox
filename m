Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVDTHvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDTHvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 03:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVDTHvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 03:51:15 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:42368 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261416AbVDTHvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:51:12 -0400
X-ORBL: [67.124.119.21]
Date: Wed, 20 Apr 2005 00:50:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050420075031.GA31785@taniwha.stupidest.org>
References: <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org> <4266062B.9060400@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4266062B.9060400@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 04:35:07PM +0900, Takashi Ikebe wrote:

> I think basic assumption between us and you is not match...

No, I think at a high-level they do.

> Our assumption, the live patching is not for debug, but for the real
> operation method to fix very very important process which can not
> stop.

I understand that.

It might be though you could probably do what you want with some kind
of enhanced ptrace or debugging interface that would also be of value
to other people and probably simple than your proposed patch.

> Live patchin fix the important process's bug without disrupting
> process.

I understand that.

> To takeover the application status, connection type
> communications(SOCK_STREAM) are need to be disconnected by close().
> Same network port is not allowed to bind by multiple processes....

AF_UNIX socket with SCM_RIGHTS

> especialy, ru_utime and ru_stime is very important to critical
> applications.

how so?  what is magical about these that can't be dealt with in
userspace should it span 2+ processes?
