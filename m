Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbTAFRQl>; Mon, 6 Jan 2003 12:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbTAFRQk>; Mon, 6 Jan 2003 12:16:40 -0500
Received: from [81.2.122.30] ([81.2.122.30]:52228 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267103AbTAFRQj>;
	Mon, 6 Jan 2003 12:16:39 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301061725.h06HP8Ur000947@darkstar.example.net>
Subject: Kernel configurator request
To: linux-kernel@vger.kernel.org
Date: Mon, 6 Jan 2003 17:25:08 +0000 (GMT)
Cc: szepe@pinerecords.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, kernel configurators have produced .config files like
this:

#
# Automatically generated make config: don't edit
#
[Very general options]

#
# Code maturity level options
#
[Code maturity level options]

#
# General setup
#
[General setup options]

..etc...

My kernel bug database parses .config files, and currently, if it
detects comments, (which don't appear to be commented out options), it
uses them to present a sorted list of options to the user.  (If there
are no comments, it remains uncategorised).

The problem is that at the moment the first, very general options, get
categorised under "Automatically generated make config: don't edit".

Obviously I can work around this, but it would seem to me to be better
to have the kernel configurators generate .config files like this:

#
# Automatically generated make config: don't edit
#

#
# Very general options
#
[Very general options]

#
# Code maturity level options
#
[Code maturity level options]

#
# General setup
#
[General setup options]

..etc...

John.
