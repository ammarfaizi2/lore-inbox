Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTKQKIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 05:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTKQKIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 05:08:35 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:130 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263497AbTKQKIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 05:08:34 -0500
Date: Mon, 17 Nov 2003 10:08:45 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031117095528.GV24159@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311171005160.1384-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> EOF had been reached when read() returns 0.  Until then read() returns
> an arbitrary amount of bytes between 1 and 'size' argument.  Since you
> are using read(2) directly, use it correctly...

I know that for read(2) in general but I thought that the whole point of 
using "sequential record" files (aka seq_file) is that they guarantee 
read(2) to return a number of fixed-size records, hence the name 
"sequential record". Especially since the ->show() function is packing 
those records into m->buf as "whole" entities, not in "halves" or such.

I believe you of course (as you wrote seq_file) but it still seems that as 
long as the implementation (i.e. my module) is working with whole records 
it is ok to assume that read() will return them as whole, i.e. not break a 
record between two calls to read(2). Is this really not true?

Kind regards
Tigran

