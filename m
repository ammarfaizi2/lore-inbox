Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTDPHpw (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 03:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTDPHpw 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 03:45:52 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:52754 "HELO
	mail.truemesh.com") by vger.kernel.org with SMTP id S264254AbTDPHpw 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 03:45:52 -0400
Date: Wed, 16 Apr 2003 09:04:12 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Steve Bangert <sbangert@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make RPM fails on Redhat-9
Message-ID: <20030416080410.GL31206@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Steve Bangert <sbangert@mindspring.com>, linux-kernel@vger.kernel.org
References: <1050444692.16505.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050444692.16505.1.camel@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 03:11:34PM -0700, Steve Bangert wrote:

> Processing files: kernel-debuginfo-2.4.21pre7-2
> error: Could not open %files file
> /usr/src/redhat/BUILD/kernel-2.4.21pre7/debugfiles.list: No such file or
> directory

Redhat 9.0 (and phoebe betas) have debug set on for rpm automatically.
The package name kernel-debuginfo implies this is where it is going
wrong.

Set up a ~/.rpmmacros file with the line

%debub_package %{nil}

And try make rpm again, this should work.

Hth

Paul
