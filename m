Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273329AbRIRK3N>; Tue, 18 Sep 2001 06:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273330AbRIRK2l>; Tue, 18 Sep 2001 06:28:41 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:36592 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273329AbRIRK2k>; Tue, 18 Sep 2001 06:28:40 -0400
Date: Tue, 18 Sep 2001 11:28:29 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Juan <piernas@ditec.um.es>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Ext3 journal on its own device?
Message-ID: <20010918112829.B12248@redhat.com>
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es>; from piernas@ditec.um.es on Mon, Sep 17, 2001 at 05:54:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, 2001 at 05:54:40PM +0200, Juan wrote:
 
> I have been browsing the Ext3 source (version 0.0.7a), and it seems
> impossible to use a block device as an Ext3 journal. Is that true?.

In the 2.2 code (ext3-0.0.7a), the journal has to be part of the
filesystem.  The current e2fsprogs and 2.4 ext3 code (ext3-0.9.9) does
support journals on other devices, but there's more support to be
added before it's truly complete (in particular we want to support
several filesystems journaling to a single shared journal spool.)

The separate-journal-disk code hasn't been tested as much as the
default journal-on-main-filesystem code, and it's not officially
supported, so the format might change in the future.  But it should
work.

Cheers,
 Stephen
