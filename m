Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbSJ0ISS>; Sun, 27 Oct 2002 03:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSJ0ISR>; Sun, 27 Oct 2002 03:18:17 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:18704 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262310AbSJ0ISQ>;
	Sun, 27 Oct 2002 03:18:16 -0500
Date: Sun, 27 Oct 2002 03:24:28 -0500 (EST)
Message-Id: <200210270824.g9R8OSI269870@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Subject: warped security
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As a non-root user:

a. I can't do readlink() on /proc/1/exe ("ls -l /proc/1/exe")
b. I can do "cat /proc/1/maps" to see what files are mapped

That's backwards. If a user can read /proc/1/cmdline, then
they might as well be permitted to readlink() on /proc/1/exe
as well. Reading /proc/1/maps is quite another matter,
exposing more info than the (prohibited) /proc/1/fd/* does.

