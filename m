Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286584AbSAKJpk>; Fri, 11 Jan 2002 04:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289588AbSAKJpa>; Fri, 11 Jan 2002 04:45:30 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:19979 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286584AbSAKJpP>; Fri, 11 Jan 2002 04:45:15 -0500
Date: Fri, 11 Jan 2002 12:45:12 +0300
From: Oleg Drokin <green@namesys.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] certain data corruption may cause reiserfs to panic, fix.
Message-ID: <20020111124512.F17925@namesys.com>
In-Reply-To: <20020109162207.A15139@namesys.com> <Pine.LNX.4.21.0201091458360.21044-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201091458360.21044-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 09, 2002 at 02:58:45PM -0200, Marcelo Tosatti wrote:

> >     Purpose of this patch is to catch events of corrupted ITEM_TYPE fields, and report these to user.
> >     Without this patch, accessing such items will resukt in dereferencing random memory areas in kernel,
> >     and then ooping (most probably).
> >     Please apply.
> Why corruption is happening in the first place ? 
As Chris already pointed out, there was a problem with old gcc 2.96.
Also such corruptions might be a fault of a disk, somebody carelessly writing data to reiserfsdisk and so on.
Right now it is way too easy to get reiserfs to panic by mounting specially crafted abd disk image, and this is
bad, I believe, so one of the tasks I am performing is to minimalize such cases. (look at ext2 as an example goal I want to achieve
some time in the future)

Bye,
    Oleg
